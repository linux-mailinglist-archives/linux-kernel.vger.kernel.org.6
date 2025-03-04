Return-Path: <linux-kernel+bounces-544315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D82A4E004
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B94F189CD87
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF871FF7BF;
	Tue,  4 Mar 2025 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vF23nCnL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC1F204C29
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096730; cv=none; b=URpJaj0hyeYFcPgKWwZtWo3Ezee6fTQW8wCM67zBGDUrudWtWe6bmtT1ATbgRb5kBdyjajX96kdPkWYAn/lcg8DDrk4wVBFAJq1m3vbRAXahmatFLdKoLIsGxY4QtiXJKHJxy0pqX8wdRjdeb0AYfRvKt1kAeO3jGDYxHvey2RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096730; c=relaxed/simple;
	bh=zGmupePrg6X0HyaMkp7BsDdleTUSKa3KpW1HRLcE7Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEGdnVTL85IJfS7uo486INagCZGI0CiXAs+y3U+VoZTx8ixbT7ldzDlHpDOc/Z13ctW71rL663B3WrnJFPkFBspvJGqk4NuphNn93Hq0eMSpr9SkEEMln8uMUMK8MtbB5OArWlRuhb9b6MCmEahBFGodHAZ+2Iwn++hb3hF9p6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vF23nCnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1BEC4CEE5;
	Tue,  4 Mar 2025 13:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741096730;
	bh=zGmupePrg6X0HyaMkp7BsDdleTUSKa3KpW1HRLcE7Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vF23nCnLD/EN0hiNA2S0Dqw90+rhjkP7uGC0lVh/1ZHuOtrBMANtrepOA+aV8+MSg
	 xgQ3p8MST+8/lt1MLO2MGozYt0O0K8QxxfiQwlnoblC+mjaG2PxViOVq2Ey1bn1u1W
	 LST5ksnoIkQCTZetTqtr14iX9Ge96BNiyflO2nZlNIdba3YhxfHu6uorNEOYk8Q1ZN
	 VA4+d0KCUxq25Nf042VOC2jEWSMDGciSFvhrCSNt7DNEHCiNNtyerc8nn3+d0/WKE7
	 np3qfANNc6IBDPhbUPt2PdJtVlJtsvBd4o0khHeqErwRCkbI7idmpiS3cAkqF1e4yW
	 jzYPtG1e7BX6Q==
From: Borislav Petkov <bp@kernel.org>
To: riel@surriel.com
Cc: Manali.Shukla@amd.com,
	akpm@linux-foundation.org,
	andrew.cooper3@citrix.com,
	jackmanb@google.com,
	jannh@google.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhklinux@outlook.com,
	nadav.amit@gmail.com,
	thomas.lendacky@amd.com,
	x86@kernel.org,
	zhengqi.arch@bytedance.com,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH v15 08/11] x86/mm: Add global ASID process exit helpers
Date: Tue,  4 Mar 2025 14:58:13 +0100
Message-ID: <20250304135816.12356-9-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304135816.12356-1-bp@kernel.org>
References: <20250304135816.12356-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rik van Riel <riel@surriel.com>

A global ASID is allocated for the lifetime of a process. Free the global ASID
at process exit time.

  [ bp: Massage, create helpers, hide details inside them. ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250226030129.530345-10-riel@surriel.com
---
 arch/x86/include/asm/mmu_context.h | 8 +++++++-
 arch/x86/include/asm/tlbflush.h    | 9 +++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

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
index 1f61a39a8776..e6c3be06dd21 100644
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
@@ -281,6 +289,7 @@ static inline bool mm_in_asid_transition(struct mm_struct *mm)
 }
 #else
 static inline u16 mm_global_asid(struct mm_struct *mm) { return 0; }
+static inline void mm_init_global_asid(struct mm_struct *mm) { }
 static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid) { }
 static inline bool mm_in_asid_transition(struct mm_struct *mm) { return false; }
 #endif /* CONFIG_BROADCAST_TLB_FLUSH */
-- 
2.43.0


