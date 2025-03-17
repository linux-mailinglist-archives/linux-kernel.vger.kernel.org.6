Return-Path: <linux-kernel+bounces-564680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8830A6591F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B93467ADE5D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8138E1B3950;
	Mon, 17 Mar 2025 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cI399+NZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sb4qrxiF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040351B0439
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230362; cv=none; b=S3Q1WwUrYPGPX7YzaOu2OFrySK/j/qWAnv3zlQwHK6MK2g3TqI6kDw12381i7lUAx/EYq3cHx4iBZfeHAILPcXJo6IC0NlV9xDiFDsE+mUo5jTtTYmULB1PjDu60PxK8UwpAhT0PNjcXQbVZFOFBZCl/5esks6Ak1TRtlpj23Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230362; c=relaxed/simple;
	bh=xYPUAVw35U2jEBdCFyEsJp23iADwkFnGv8i46USFWhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqjeBXGdfGKF8/6GJBoECZAyOz5yegqWRBuDWu+Pjp8c3pwSf4Zlvp8K0J5v4L5vbmyQIywXBXzw3qeMtx7CP3TNmPuNwQNuZLRSVFk91+rtJHHCfPsE8J3Bbp50Cf4C1mLYYcoU93v4mkq7a080CqoIipf/uUH2jd1E8Ogg/9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cI399+NZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sb4qrxiF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0mYjI9whW3MtZZBkiK7m7XbYog0xGy6k2xNgys5gJ0=;
	b=cI399+NZKDhnT0bjsPmjB/sz6zGHs83ibJmLT81UHleHt1bixHSm77AFKCWUhNLqfOhWUY
	p1w4wuLjSuF6zAZuFI+xshiGXyBvoqJ0VqN8o6xki2ODtip2ni58QAP3v9heB1yrRMHFmc
	k+0TuN+lQHzOgBKT1+qHNZHgqPXDjS1tKZ3OXeBMa2n16TLt/j98Bo1J4F3QJeRn/mUUSk
	1Hj+ICFvMJfKT8qamMgw72yo6KpChF6iik4Qy2Gqairb9sFtb+p10MyzBeS01oUhTUTDK9
	pSCromklegKp4+Gh3MJ1NkHFaQII+KfH3KMaFTorrMSh0LwFuJCOHkqVqdSv+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0mYjI9whW3MtZZBkiK7m7XbYog0xGy6k2xNgys5gJ0=;
	b=sb4qrxiFGFG2tGXE7G0wr5YodFe7XeEY4iZ5jYLi2Nllbh20aQUTaTSEDgvEa/98HfqHTO
	6UDH/O0kg65njJBA==
To: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 03/29] x86/cpu: Remove leaf 0x2 parsing loop and add helpers
Date: Mon, 17 Mar 2025 17:47:19 +0100
Message-ID: <20250317164745.4754-4-darwi@linutronix.de>
In-Reply-To: <20250317164745.4754-1-darwi@linutronix.de>
References: <20250317164745.4754-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Leaf 0x2 output includes a "query count" byte where it was supposed to
specify the number of repeated CPUID leaf 0x2 subleaf 0 queries needed
to extract all of the hardware's cache and TLB descriptors.

Per current Intel manuals, all CPUs supporting this leaf "will always"
return an iteration count of 1.

Remove the leaf 0x2 query count loop and just query the hardware once.
Parse the output with C99 bitfields instead of ugly bitwise operations.

Provide leaf 0x2 parsing helpers with all the above.  Use such helpers
at x86/cpu intel.c.  Further commits will use them for x86/cacheinfo.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid.h              |  1 +
 arch/x86/include/asm/cpuid/leaf_0x2_api.h | 65 +++++++++++++++++++++++
 arch/x86/include/asm/cpuid/types.h        | 16 ++++++
 arch/x86/kernel/cpu/intel.c               | 24 +++------
 4 files changed, 88 insertions(+), 18 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuid/leaf_0x2_api.h

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index d5749b25fa10..585819331dc6 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -4,5 +4,6 @@
 #define _ASM_X86_CPUID_H
 
 #include <asm/cpuid/api.h>
+#include <asm/cpuid/leaf_0x2_api.h>
 
 #endif /* _ASM_X86_CPUID_H */
diff --git a/arch/x86/include/asm/cpuid/leaf_0x2_api.h b/arch/x86/include/asm/cpuid/leaf_0x2_api.h
new file mode 100644
index 000000000000..b64e4a20a3ce
--- /dev/null
+++ b/arch/x86/include/asm/cpuid/leaf_0x2_api.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CPUID_LEAF_0x2_API_H
+#define _ASM_X86_CPUID_LEAF_0x2_API_H
+
+#include <asm/cpuid/api.h>
+#include <asm/cpuid/types.h>
+
+/**
+ * cpuid_get_leaf_0x2_regs() - Return sanitized leaf 0x2 register output
+ * @regs:	Output parameter
+ *
+ * Query CPUID leaf 0x2 and store its output in @regs.  Force set any
+ * invalid 1-byte descriptor returned by the hardware to zero (the NULL
+ * cache/TLB descriptor) before returning it to the caller.
+ *
+ * Use for_each_leaf_0x2_desc() to iterate over the returned output.
+ */
+static inline void cpuid_get_leaf_0x2_regs(union leaf_0x2_regs *regs)
+{
+	cpuid_leaf(0x2, regs);
+
+	/*
+	 * All Intel CPUs must report an iteration count of 1.  In case
+	 * of bogus hardware, treat all returned descriptors as NULL.
+	 */
+	if (regs->desc[0] != 0x01) {
+		for (int i = 0; i < 4; i++)
+			regs->regv[i] = 0;
+		return;
+	}
+
+	/*
+	 * The most significant bit (MSB) of each register must be clear.
+	 * If a register is invalid, replace its descriptors with NULL.
+	 */
+	for (int i = 0; i < 4; i++) {
+		if (regs->reg[i].invalid)
+			regs->regv[i] = 0;
+	}
+}
+
+/**
+ * for_each_leaf_0x2_desc() - Iterator for CPUID leaf 0x2 descriptors
+ * @regs:	Leaf 0x2 output, as returned by cpuid_get_leaf_0x2_regs()
+ * @desc:	Pointer to the returned descriptor for each iteration
+ *
+ * Loop over the 1-byte descriptors in the passed leaf 0x2 output registers
+ * @regs.  Provide each descriptor through @desc.
+ *
+ * Note that the first byte is skipped as it is not a descriptor.
+ *
+ * Sample usage::
+ *
+ *	union leaf_0x2_regs regs;
+ *	u8 *desc;
+ *
+ *	cpuid_get_leaf_0x2_regs(&regs);
+ *	for_each_leaf_0x2_desc(regs, desc) {
+ *		// Handle *desc value
+ *	}
+ */
+#define for_each_leaf_0x2_desc(regs, desc)				\
+	for (desc = &(regs).desc[1]; desc < &(regs).desc[16]; desc++)
+
+#endif /* _ASM_X86_CPUID_LEAF_0x2_API_H */
diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 724002aaff4d..864047113e37 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -26,4 +26,20 @@ enum cpuid_regs_idx {
 #define CPUID_LEAF_FREQ		0x16
 #define CPUID_LEAF_TILE		0x1d
 
+/*
+ * Types for CPUID(0x2) parsing
+ * Check <asm/cpuid/leaf_0x2_api.h>
+ */
+
+struct leaf_0x2_reg {
+		u32		: 31,
+			invalid	: 1;
+};
+
+union leaf_0x2_regs {
+	struct leaf_0x2_reg	reg[4];
+	u32			regv[4];
+	u8			desc[16];
+};
+
 #endif /* _ASM_X86_CPUID_TYPES_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 291c82816797..bf735cee9e76 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -15,6 +15,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu.h>
+#include <asm/cpuid.h>
 #include <asm/hwcap2.h>
 #include <asm/intel-family.h>
 #include <asm/microcode.h>
@@ -779,28 +780,15 @@ static void intel_tlb_lookup(const unsigned char desc)
 
 static void intel_detect_tlb(struct cpuinfo_x86 *c)
 {
-	int i, j, n;
-	unsigned int regs[4];
-	unsigned char *desc = (unsigned char *)regs;
+	union leaf_0x2_regs regs;
+	u8 *desc;
 
 	if (c->cpuid_level < 2)
 		return;
 
-	/* Number of times to iterate */
-	n = cpuid_eax(2) & 0xFF;
-
-	for (i = 0 ; i < n ; i++) {
-		cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
-
-		/* If bit 31 is set, this is an unknown format */
-		for (j = 0 ; j < 4 ; j++)
-			if (regs[j] & (1 << 31))
-				regs[j] = 0;
-
-		/* Byte 0 is level count, not a descriptor */
-		for (j = 1 ; j < 16 ; j++)
-			intel_tlb_lookup(desc[j]);
-	}
+	cpuid_get_leaf_0x2_regs(&regs);
+	for_each_leaf_0x2_desc(regs, desc)
+		intel_tlb_lookup(*desc);
 }
 
 static const struct cpu_dev intel_cpu_dev = {
-- 
2.48.1


