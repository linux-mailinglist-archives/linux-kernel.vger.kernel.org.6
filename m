Return-Path: <linux-kernel+bounces-544309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C01DA4E000
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F113B5454
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70BC204C29;
	Tue,  4 Mar 2025 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZIgd2wB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524EE204C13
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096710; cv=none; b=eHxRaZYf5rjI/4kK4GrQPpFxsHMuAufJjfHou9hXNUX9oPcdPHAkAHNKi5O1/DD+KqYp+5b7iQTwHIa/3cc61zIDBnasNL9T2515DM8x2gaJrdcZEuxqaYA5Au+JMILdiBY+g3PYNI7gj0CGMJXDjJFFCqI0NjdNHo5jaYkyBak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096710; c=relaxed/simple;
	bh=RTPSleP7Ih9cuOhakawnif+qFen0hQD2ElBjJf/R2uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8Xh8MNVCaHwOYHXePEt7/YgFPfrF7PY8vkJImlbgKmJ6rf29SgsHfdD3BbR5UxC0bYd3Y9C4Q9Bp693YDpfoVtuFI59iK00tNXqGr99u7HeNUBEnpy5TpjcG2IberVnqFGUv1OSlGS69CQFZt5rwaZJcU1kjHpL39u+Xi6EWS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZIgd2wB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06C1C4CEE5;
	Tue,  4 Mar 2025 13:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741096709;
	bh=RTPSleP7Ih9cuOhakawnif+qFen0hQD2ElBjJf/R2uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZIgd2wB3QlNyLuuLAxLvQkYbI3bmfHrOI1t5jIwzoVCi+tTxuy/UGkhYq/jlZt4L
	 28ZJV3wE2+RmDHPbX3VGbOG6rF+xcIOp+QX2XWIFMii1TdPtzyu3iVjxbqX5tPed83
	 nTj6XLNc+HT049+p4GrntMUWDjtpHP0PfvInJPB0BpQS1S/gByelbiR1Vs/h3pWme0
	 aFL/oYfdxO0b25B1iYW/5amNk1nOO5VG8hcpCXucZVs8oUsp66yJg+VrG+BCuv8Sj1
	 VuIlrn1ixV9FAzTp+YFM/4pi8jPMbqyCjDthffiyEgv7GQJgmda+06qO3pqH8o9+kH
	 JaLL+fZtldtew==
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
Subject: [PATCH v15 02/11] x86/mm: Add INVLPGB feature and Kconfig entry
Date: Tue,  4 Mar 2025 14:58:07 +0100
Message-ID: <20250304135816.12356-3-bp@kernel.org>
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

In addition, the CPU advertises the maximum number of pages that can be
shot down with one INVLPGB instruction in CPUID. Save that information
for later use.

  [ bp: use cpu_has(), typos, massage. ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250226030129.530345-3-riel@surriel.com
---
 arch/x86/Kconfig.cpu                     | 4 ++++
 arch/x86/include/asm/cpufeatures.h       | 1 +
 arch/x86/include/asm/disabled-features.h | 8 +++++++-
 arch/x86/include/asm/tlbflush.h          | 3 +++
 arch/x86/kernel/cpu/amd.c                | 6 ++++++
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 2a7279d80460..25c55cc17c5e 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -401,6 +401,10 @@ menuconfig PROCESSOR_SELECT
 	  This lets you choose what x86 vendor support code your kernel
 	  will include.
 
+config BROADCAST_TLB_FLUSH
+	def_bool y
+	depends on CPU_SUP_AMD && 64BIT
+
 config CPU_SUP_INTEL
 	default y
 	bool "Support Intel processors" if PROCESSOR_SELECT
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 508c0dad116b..8770dc185fe9 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -338,6 +338,7 @@
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* "clzero" CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* "irperf" Instructions Retired Count */
 #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* "xsaveerptr" Always save/restore FP error pointers */
+#define X86_FEATURE_INVLPGB		(13*32+ 3) /* INVLPGB and TLBSYNC instructions supported */
 #define X86_FEATURE_RDPRU		(13*32+ 4) /* "rdpru" Read processor register at user level */
 #define X86_FEATURE_WBNOINVD		(13*32+ 9) /* "wbnoinvd" WBNOINVD instruction */
 #define X86_FEATURE_AMD_IBPB		(13*32+12) /* Indirect Branch Prediction Barrier */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index c492bdc97b05..625a89259968 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -129,6 +129,12 @@
 #define DISABLE_SEV_SNP		(1 << (X86_FEATURE_SEV_SNP & 31))
 #endif
 
+#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
+#define DISABLE_INVLPGB		0
+#else
+#define DISABLE_INVLPGB		(1 << (X86_FEATURE_INVLPGB & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -146,7 +152,7 @@
 #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
 			 DISABLE_CALL_DEPTH_TRACKING|DISABLE_USER_SHSTK)
 #define DISABLED_MASK12	(DISABLE_FRED|DISABLE_LAM)
-#define DISABLED_MASK13	0
+#define DISABLED_MASK13	(DISABLE_INVLPGB)
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
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
index 54194f5995de..7a72ef47a983 100644
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
+	if (cpu_has(c, X86_FEATURE_INVLPGB))
+		invlpgb_count_max = (cpuid_edx(0x80000008) & 0xffff) + 1;
 }
 
 static const struct cpu_dev amd_cpu_dev = {
-- 
2.43.0


