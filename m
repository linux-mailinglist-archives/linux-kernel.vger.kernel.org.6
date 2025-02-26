Return-Path: <linux-kernel+bounces-532900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C50A45392
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA72C3A9958
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4AE22068E;
	Wed, 26 Feb 2025 03:01:50 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7EC19CD13
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538909; cv=none; b=mi01U9biXB/bHAk/7b2v63HI8kcT+WgGZkl2IzvChXd6XHk5b/xyIEJPIYHEVTxcT7q4LJDrQ+tUWYkHcShsoYwu6y1tbzTPN0zdEGp47sZNrFEVVOjgPYmaJlgGWjRgQEC3tGIypxhbkowf36vei3Ar7N6lD2xDXp8x/VVuB7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538909; c=relaxed/simple;
	bh=3wrtkh9xxpMyJ6KYbh0G7oUdYiFGwpJXzauJ24ACMjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLGrtib/heiIR3CUvXgt5OMivoDGTr5DDp62wfjF68O6PiYM2CzgLGTg+LToqLQ5PWEszXV4A9mVofN1/mGfNTfoOHsXImIYGYY4dg20JrHEdi3JC6xhI/AWg5q5WujlEOcenplUPUd0TV5Au/5r12nV+hxsYvQYIpMkC/ZoVbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tn7fw-000000001Y5-0Swe;
	Tue, 25 Feb 2025 22:01:32 -0500
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
	Manali.Shukla@amd.com,
	mingo@kernel.org,
	Rik van Riel <riel@surriel.com>,
	Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v14 02/13] x86/mm: get INVLPGB count max from CPUID
Date: Tue, 25 Feb 2025 22:00:37 -0500
Message-ID: <20250226030129.530345-3-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250226030129.530345-1-riel@surriel.com>
References: <20250226030129.530345-1-riel@surriel.com>
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
Tested-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
---
 arch/x86/Kconfig.cpu               | 4 ++++
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/include/asm/tlbflush.h    | 3 +++
 arch/x86/kernel/cpu/amd.c          | 6 ++++++
 4 files changed, 14 insertions(+)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 2a7279d80460..981def9cbfac 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -401,6 +401,10 @@ menuconfig PROCESSOR_SELECT
 	  This lets you choose what x86 vendor support code your kernel
 	  will include.
 
+config X86_BROADCAST_TLB_FLUSH
+	def_bool y
+	depends on CPU_SUP_AMD && 64BIT
+
 config CPU_SUP_INTEL
 	default y
 	bool "Support Intel processors" if PROCESSOR_SELECT
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 508c0dad116b..b5c66b7465ba 100644
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
index 3da645139748..855c13da2045 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -183,6 +183,9 @@ static inline void cr4_init_shadow(void)
 extern unsigned long mmu_cr4_features;
 extern u32 *trampoline_cr4_features;
 
+/* How many pages can be invalidated with one INVLPGB. */
+extern u16 invlpgb_count_max;
+
 extern void initialize_tlbstate_and_flush(void);
 
 /*
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 54194f5995de..3c75c174a274 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -29,6 +29,8 @@
 
 #include "cpu.h"
 
+u16 invlpgb_count_max __ro_after_init;
+
 static inline int rdmsrl_amd_safe(unsigned msr, unsigned long long *p)
 {
 	u32 gprs[8] = { 0 };
@@ -1139,6 +1141,10 @@ static void cpu_detect_tlb_amd(struct cpuinfo_x86 *c)
 		tlb_lli_2m[ENTRIES] = eax & mask;
 
 	tlb_lli_4m[ENTRIES] = tlb_lli_2m[ENTRIES] >> 1;
+
+	/* Max number of pages INVLPGB can invalidate in one shot */
+	if (boot_cpu_has(X86_FEATURE_INVLPGB))
+		invlpgb_count_max = (cpuid_edx(0x80000008) & 0xffff) + 1;
 }
 
 static const struct cpu_dev amd_cpu_dev = {
-- 
2.47.1


