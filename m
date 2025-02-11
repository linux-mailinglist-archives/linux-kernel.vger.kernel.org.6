Return-Path: <linux-kernel+bounces-510020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFF8A31756
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12E73A8E45
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37B5267F5E;
	Tue, 11 Feb 2025 21:08:38 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6FA265CA6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308118; cv=none; b=tEzQFoYFtHsNJDr6xc919UpWnxdPxTu7QPJaMnPyJUn3ys8STyk2ye+gLfsaSTndT0bBbJxVGF/HHc597A1qMYv4VTARacWc0kCpF7ucuBDrU4KMEHE1AZiFCVXSO9R/ShS9CRdqbVfBIeBfyesx9iejNOhaCY5AKn/H+4BmIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308118; c=relaxed/simple;
	bh=hTHmlQ0VzReZS/OF/u999clkXFK2cBoZAn7kF/b02KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1mi/Hk49twByMd6Mqjy7N41IE2Rkifo3kF0aK3cw0rD8tMOfYHGlRUbo4O4wxOd1LnirkV2hRxxFKFA8e7M8XTmyd3Lm0X+G5jwzjHdZWTvcG0GI++sdsqE+ne8AFig5yy3h2D+w4YBHfM2x+xQxkRaKPexeR7KJgoQjOSNTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1thxUX-000000008HU-2paU;
	Tue, 11 Feb 2025 16:08:25 -0500
From: Rik van Riel <riel@surriel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bp@alien8.de,
	peterz@infradead.org,
	dave.hansen@linux.intel.com,
	zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com,
	thomas.lendacky@amd.com,
	kernel-team@meta.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	jackmanb@google.com,
	jannh@google.com,
	mhklinux@outlook.com,
	andrew.cooper3@citrix.com,
	Rik van Riel <riel@surriel.com>,
	Manali Shukla <Manali.Shukla@amd.com>
Subject: [PATCH v10 04/12] x86/mm: get INVLPGB count max from CPUID
Date: Tue, 11 Feb 2025 16:07:59 -0500
Message-ID: <20250211210823.242681-5-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250211210823.242681-1-riel@surriel.com>
References: <20250211210823.242681-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

The CPU advertises the maximum number of pages that can be shot down
with one INVLPGB instruction in the CPUID data.

Save that information for later use.

Signed-off-by: Rik van Riel <riel@surriel.com>
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/Kconfig.cpu               | 5 +++++
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/include/asm/tlbflush.h    | 7 +++++++
 arch/x86/kernel/cpu/amd.c          | 8 ++++++++
 4 files changed, 21 insertions(+)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 2a7279d80460..abe013a1b076 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -395,6 +395,10 @@ config X86_VMX_FEATURE_NAMES
 	def_bool y
 	depends on IA32_FEAT_CTL
 
+config X86_BROADCAST_TLB_FLUSH
+	def_bool y
+	depends on CPU_SUP_AMD && 64BIT
+
 menuconfig PROCESSOR_SELECT
 	bool "Supported processor vendors" if EXPERT
 	help
@@ -431,6 +435,7 @@ config CPU_SUP_CYRIX_32
 config CPU_SUP_AMD
 	default y
 	bool "Support AMD processors" if PROCESSOR_SELECT
+	select X86_BROADCAST_TLB_FLUSH
 	help
 	  This enables detection, tunings and quirks for AMD processors
 
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 17b6590748c0..f9b832e971c5 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -338,6 +338,7 @@
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* "clzero" CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* "irperf" Instructions Retired Count */
 #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* "xsaveerptr" Always save/restore FP error pointers */
+#define X86_FEATURE_INVLPGB		(13*32+ 3) /* INVLPGB and TLBSYNC instruction supported. */
 #define X86_FEATURE_RDPRU		(13*32+ 4) /* "rdpru" Read processor register at user level */
 #define X86_FEATURE_WBNOINVD		(13*32+ 9) /* "wbnoinvd" WBNOINVD instruction */
 #define X86_FEATURE_AMD_IBPB		(13*32+12) /* Indirect Branch Prediction Barrier */
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 02fc2aa06e9e..8fe3b2dda507 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -183,6 +183,13 @@ static inline void cr4_init_shadow(void)
 extern unsigned long mmu_cr4_features;
 extern u32 *trampoline_cr4_features;
 
+/* How many pages can we invalidate with one INVLPGB. */
+#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
+extern u16 invlpgb_count_max;
+#else
+#define invlpgb_count_max 1
+#endif
+
 extern void initialize_tlbstate_and_flush(void);
 
 /*
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 79d2e17f6582..bcf73775b4f8 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -29,6 +29,8 @@
 
 #include "cpu.h"
 
+u16 invlpgb_count_max __ro_after_init;
+
 static inline int rdmsrl_amd_safe(unsigned msr, unsigned long long *p)
 {
 	u32 gprs[8] = { 0 };
@@ -1135,6 +1137,12 @@ static void cpu_detect_tlb_amd(struct cpuinfo_x86 *c)
 		tlb_lli_2m[ENTRIES] = eax & mask;
 
 	tlb_lli_4m[ENTRIES] = tlb_lli_2m[ENTRIES] >> 1;
+
+	/* Max number of pages INVLPGB can invalidate in one shot */
+	if (boot_cpu_has(X86_FEATURE_INVLPGB)) {
+		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
+		invlpgb_count_max = (edx & 0xffff) + 1;
+	}
 }
 
 static const struct cpu_dev amd_cpu_dev = {
-- 
2.47.1


