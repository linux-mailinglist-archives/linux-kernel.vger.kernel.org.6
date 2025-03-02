Return-Path: <linux-kernel+bounces-540516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BC9A4B199
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 13:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE62B3B05EE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 12:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EDB1DF733;
	Sun,  2 Mar 2025 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LaTpfNMt"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845D3FC0E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740919161; cv=none; b=S7x+zINr8TJpo1UrcFnF88HWz22H7mrMmS+dWGP4OxfGv3ReQSZVvElZueJ3E0CrRxQ84WJkREj1DwoBgrn+v8ezpvCRxz8eD8UcU5IpgYIXNFReiAX+2u1PhARLu8tySTfi1uOmqfA51JxCJedvP6pXUnUOZxUGudjD9koGVnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740919161; c=relaxed/simple;
	bh=HG9KM8Ao12+9rVu116d9LaoaDZKJ1fcaUPZTeFiSFrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7RqbdAqFcORh/wOX1+MAStT2pH0kd1zAzk/cz7oJlnR9UUx9LLOTfxPIqMMDhita/g2vMTTlo7l5lGlmRt3KjoTkzpQwf6tyRS9Pxig2/H5xjMiET/j1lvdgpQ8CEvXg/W4Tm+S4imQ/QUnayJj98GYRzQrQy0SVOd8qjOEo1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LaTpfNMt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9717340E0173;
	Sun,  2 Mar 2025 12:39:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id B2qApUVk9KQI; Sun,  2 Mar 2025 12:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740919142; bh=YqpmSp/8nDQKww323mMJ1c1TGuRr+68wTo8FomD32pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LaTpfNMtmFGHxlGMTdWV8zk9bBy7zNdaQXA2QwRaCfQhx/r7jY8VRaGp0vlXYN64e
	 R9dhi06wuFr5UufJSsebzgOtpTK8vA972WtjoZUgLQfgH7ac9+XqdJbuZ1FUCizXTt
	 rbqMS6F+zm4TFBAuXsRUTScMsHOJuR+lqjpIlLKMSrdMGuAuiGxHzt5NcAZic1zUs1
	 H3k48TyRV8eb32lNziF82wdl/SnWLqJIb7i+9ate1+HMrIDR2+/JCIi8NCpjuNH2zR
	 ariWtoiTxcnZXCPzcRir0xKxIylIn+WigL1GaSkY+Ar/fl6xu681Sp0P6jWZ1How3Q
	 Rn/AjUhwd85Wlvm2HGmuAMhMyI9Qv8WDijcg3bm9D6GXd6m9tgmSpSMrDdHgdKO6KV
	 mXffLhmGgMCo0KClwUaIc69nFtVIRRM9pGQxa0/1ZUlRX2lifMW+Lq57kovMgKlj3R
	 QCVaxDl5vpWr6GBOrMjte0QnOLl5i4OUYlF8gpldT3cdkQnzd70G0v13cayEgzYyyz
	 Yc3ojXvbABdFkDXR/wgmt+ZBj6oFHhAmuEaRYE3jScASe+q5MPRUMHjf6t8c8aJNWs
	 lW1HyE6HE2sKc0QpA63qcjI/8vz0E5upSO+n0tJ72QUnYgaybcIhai1SbTKhuxi1sm
	 nT1z6MCrqBhg/A2w+9iRiB44=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5FBF440E0028;
	Sun,  2 Mar 2025 12:38:45 +0000 (UTC)
Date: Sun, 2 Mar 2025 13:38:38 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v14 09/13] x86/mm: global ASID process exit helpers
Message-ID: <20250302123838.GKZ8RRTgRxvBSry6mk@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-10-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226030129.530345-10-riel@surriel.com>

On Tue, Feb 25, 2025 at 10:00:44PM -0500, Rik van Riel wrote:
> A global ASID is allocated for the lifetime of a process.
> 
> Free the global ASID at process exit time.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  arch/x86/include/asm/mmu_context.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

So I don't like the ifdeffery and tried removing it, see below.

So I added helpers.

Then I entered the include hell.

And then I caught a bug with the DISABLED_FEATURE stuff.

Anyway, see below. It builds the allno-, defconfig and mine I use on this
machine so more testing is definitely needed. But the end result looks a lot
better now.

I'll integrate the other changes into the respective patches and I probably
should push my branch somewhere as we have accumulated a lot of changes by now
so tracking them over mail is getting not that easy anymore.

Will do so on Monday.

diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
index f9af51205f07..3207e5546438 100644
--- a/arch/x86/Kconfig.cpufeatures
+++ b/arch/x86/Kconfig.cpufeatures
@@ -196,6 +196,6 @@ config X86_DISABLED_FEATURE_SEV_SNP
 	def_bool y
 	depends on !KVM_AMD_SEV
 
-config X86_DISABLED_FEATURE_BROADCAST_TLB_FLUSH
+config X86_DISABLED_FEATURE_INVLPGB
 	def_bool y
 	depends on !X86_BROADCAST_TLB_FLUSH
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index a2c70e495b1b..2398058b6e83 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -2,7 +2,6 @@
 #ifndef _ASM_X86_MMU_CONTEXT_H
 #define _ASM_X86_MMU_CONTEXT_H
 
-#include <asm/desc.h>
 #include <linux/atomic.h>
 #include <linux/mm_types.h>
 #include <linux/pkeys.h>
@@ -13,6 +12,7 @@
 #include <asm/paravirt.h>
 #include <asm/debugreg.h>
 #include <asm/gsseg.h>
+#include <asm/desc.h>
 
 extern atomic64_t last_mm_ctx_id;
 
@@ -139,6 +139,9 @@ static inline void mm_reset_untag_mask(struct mm_struct *mm)
 #define enter_lazy_tlb enter_lazy_tlb
 extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
 
+#define mm_init_global_asid mm_init_global_asid
+extern void mm_init_global_asid(struct mm_struct *mm);
+
 extern void mm_free_global_asid(struct mm_struct *mm);
 
 /*
@@ -163,6 +166,8 @@ static inline int init_new_context(struct task_struct *tsk,
 		mm->context.execute_only_pkey = -1;
 	}
 #endif
+
+	mm_init_global_asid(mm);
 	mm_reset_untag_mask(mm);
 	init_new_context_ldt(mm);
 	return 0;
@@ -172,6 +177,7 @@ static inline int init_new_context(struct task_struct *tsk,
 static inline void destroy_context(struct mm_struct *mm)
 {
 	destroy_context_ldt(mm);
+	mm_free_global_asid(mm);
 }
 
 extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 37b735dcf025..01d8a152f04a 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -261,6 +261,14 @@ static inline u16 mm_global_asid(struct mm_struct *mm)
 	return asid;
 }
 
+static inline void mm_init_global_asid(struct mm_struct *mm)
+{
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
+		mm->context.global_asid = 0;
+		mm->context.asid_transition = false;
+	}
+}
+
 static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid)
 {
 	/*
@@ -272,7 +280,7 @@ static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid)
 	smp_store_release(&mm->context.global_asid, asid);
 }
 
-static inline bool in_asid_transition(struct mm_struct *mm)
+static inline bool mm_in_asid_transition(struct mm_struct *mm)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
 		return false;
@@ -280,19 +288,10 @@ static inline bool in_asid_transition(struct mm_struct *mm)
 	return mm && READ_ONCE(mm->context.asid_transition);
 }
 #else
-static inline u16 mm_global_asid(struct mm_struct *mm)
-{
-	return 0;
-}
-
-static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid)
-{
-}
-
-static inline bool in_asid_transition(struct mm_struct *mm)
-{
-	return false;
-}
+static inline u16 mm_global_asid(struct mm_struct *mm) { return 0; }
+static inline void mm_init_global_asid(struct mm_struct *mm) { }
+static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid) { }
+static inline bool mm_in_asid_transition(struct mm_struct *mm) { return false; }
 #endif
 
 #ifdef CONFIG_PARAVIRT
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index cb43ab08ea4a..c2167b331bbe 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -396,6 +396,9 @@ static void use_global_asid(struct mm_struct *mm)
 
 void mm_free_global_asid(struct mm_struct *mm)
 {
+	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		return;
+
 	if (!mm_global_asid(mm))
 		return;
 
@@ -1161,7 +1164,7 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
 	 * up on the new contents of what used to be page tables, while
 	 * doing a speculative memory access.
 	 */
-	if (info->freed_tables || in_asid_transition(info->mm))
+	if (info->freed_tables || mm_in_asid_transition(info->mm))
 		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
 	else
 		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

