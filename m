Return-Path: <linux-kernel+bounces-565137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B22A661A9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B369A3B57C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE46720550A;
	Mon, 17 Mar 2025 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2B/+aVV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D156D2054EE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250650; cv=none; b=Dwe/69ZDqbE0kzV6ULIMqCPUe2nmKkvSQ4dyYMCQe0z5YOyzb51NoGhSRuSMUiS2iWBIc3qmSNKyCUH49yz8QPvuQvYLsa+yvH10Xpmunypn1WC+d66SX3tB1E5JzftPZZZy3LsyrqfL0OhspC0iF8gqG4GnE+g+ENV9wz6WYvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250650; c=relaxed/simple;
	bh=WcEGww208zy+bPxqapBsXHqvk/kENIpTy7JJ2c8+Q7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOosLo+CfJui81ZG0+7Gu20xbM0XvlnntAyc1jwyI7iwFojSFb5L/zxukMxWnmqKn2Dl2iMpQ2sJlicJ41aZysCt62hU9G/nLJtfonE2rLwchvIfv8dc0rZ7b3GGzHaLve8Hjg7H+TzadH2o/Osjq+aoSpxsGkbi3QnWHruJd8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2B/+aVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F5EC4CEEF;
	Mon, 17 Mar 2025 22:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742250650;
	bh=WcEGww208zy+bPxqapBsXHqvk/kENIpTy7JJ2c8+Q7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2B/+aVVk7nDYQrgIwFJXohIFsYXYvnD962cyBxkWG6iHr7JZVqltxEPgOdr94s+l
	 uZxRbujw08JGP5PfVMKLl605oy+hMxbgqY84Met2+26mp6GcdOFuMeNp/FMo92EbYd
	 7mCJly/aacNctcCEpwCYpC0jvx0ziC5t0oxqKiEgMoPDgXfY4w0Bp3dD0AOCr5Xuue
	 vhv+9ZItl37MPByIwiLy9jbCLP0PFQT/tVnwVBSYpZ78Wi0Ax9vML7MgqAvU+xn8Hh
	 I0nwMLDpocDhPGb4lGnW04/BnAIEnl3Att/EFffO7hcXMbJTy499Nyx3LnEyOrD2Ui
	 BMZhyIYBOY9cw==
From: mingo@kernel.org
To: linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/5] x86/cpuid: Refactor <asm/cpuid.h>
Date: Mon, 17 Mar 2025 23:30:35 +0100
Message-ID: <20250317223039.3741082-2-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250317223039.3741082-1-mingo@kernel.org>
References: <20250317223039.3741082-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Ahmed S. Darwish" <darwi@linutronix.de>

In preparation for future commits where CPUID headers will be expanded,
refactor the CPUID header <asm/cpuid.h> into:

    asm/cpuid/
    ├── api.h
    └── types.h

Move the CPUID data structures into <asm/cpuid/types.h> and the access
APIs into <asm/cpuid/api.h>.  Let <asm/cpuid.h> be just an include of
<asm/cpuid/api.h> so that existing call sites do not break.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250317164745.4754-3-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid.h       | 217 +--------------------------------------------------------
 arch/x86/include/asm/cpuid/api.h   | 208 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/cpuid/types.h |  29 ++++++++
 3 files changed, 238 insertions(+), 216 deletions(-)

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index a92e4b08820a..d5749b25fa10 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -1,223 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/*
- * CPUID-related helpers/definitions
- */
 
 #ifndef _ASM_X86_CPUID_H
 #define _ASM_X86_CPUID_H
 
-#include <linux/build_bug.h>
-#include <linux/types.h>
-
-#include <asm/string.h>
-
-struct cpuid_regs {
-	u32 eax, ebx, ecx, edx;
-};
-
-enum cpuid_regs_idx {
-	CPUID_EAX = 0,
-	CPUID_EBX,
-	CPUID_ECX,
-	CPUID_EDX,
-};
-
-#define CPUID_LEAF_MWAIT	0x5
-#define CPUID_LEAF_DCA		0x9
-#define CPUID_LEAF_XSTATE	0x0d
-#define CPUID_LEAF_TSC		0x15
-#define CPUID_LEAF_FREQ		0x16
-#define CPUID_LEAF_TILE		0x1d
-
-#ifdef CONFIG_X86_32
-bool have_cpuid_p(void);
-#else
-static inline bool have_cpuid_p(void)
-{
-	return true;
-}
-#endif
-static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
-				unsigned int *ecx, unsigned int *edx)
-{
-	/* ecx is often an input as well as an output. */
-	asm volatile("cpuid"
-	    : "=a" (*eax),
-	      "=b" (*ebx),
-	      "=c" (*ecx),
-	      "=d" (*edx)
-	    : "0" (*eax), "2" (*ecx)
-	    : "memory");
-}
-
-#define native_cpuid_reg(reg)					\
-static inline unsigned int native_cpuid_##reg(unsigned int op)	\
-{								\
-	unsigned int eax = op, ebx, ecx = 0, edx;		\
-								\
-	native_cpuid(&eax, &ebx, &ecx, &edx);			\
-								\
-	return reg;						\
-}
-
-/*
- * Native CPUID functions returning a single datum.
- */
-native_cpuid_reg(eax)
-native_cpuid_reg(ebx)
-native_cpuid_reg(ecx)
-native_cpuid_reg(edx)
-
-#ifdef CONFIG_PARAVIRT_XXL
-#include <asm/paravirt.h>
-#else
-#define __cpuid			native_cpuid
-#endif
-
-/*
- * Generic CPUID function
- * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
- * resulting in stale register contents being returned.
- */
-static inline void cpuid(unsigned int op,
-			 unsigned int *eax, unsigned int *ebx,
-			 unsigned int *ecx, unsigned int *edx)
-{
-	*eax = op;
-	*ecx = 0;
-	__cpuid(eax, ebx, ecx, edx);
-}
-
-/* Some CPUID calls want 'count' to be placed in ecx */
-static inline void cpuid_count(unsigned int op, int count,
-			       unsigned int *eax, unsigned int *ebx,
-			       unsigned int *ecx, unsigned int *edx)
-{
-	*eax = op;
-	*ecx = count;
-	__cpuid(eax, ebx, ecx, edx);
-}
-
-/*
- * CPUID functions returning a single datum
- */
-static inline unsigned int cpuid_eax(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	return eax;
-}
-
-static inline unsigned int cpuid_ebx(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	return ebx;
-}
-
-static inline unsigned int cpuid_ecx(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	return ecx;
-}
-
-static inline unsigned int cpuid_edx(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	return edx;
-}
-
-static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32 *regs)
-{
-	regs[CPUID_EAX] = leaf;
-	regs[CPUID_ECX] = subleaf;
-	__cpuid(regs + CPUID_EAX, regs + CPUID_EBX, regs + CPUID_ECX, regs + CPUID_EDX);
-}
-
-#define cpuid_subleaf(leaf, subleaf, regs) {		\
-	static_assert(sizeof(*(regs)) == 16);		\
-	__cpuid_read(leaf, subleaf, (u32 *)(regs));	\
-}
-
-#define cpuid_leaf(leaf, regs) {			\
-	static_assert(sizeof(*(regs)) == 16);		\
-	__cpuid_read(leaf, 0, (u32 *)(regs));		\
-}
-
-static inline void __cpuid_read_reg(unsigned int leaf, unsigned int subleaf,
-				    enum cpuid_regs_idx regidx, u32 *reg)
-{
-	u32 regs[4];
-
-	__cpuid_read(leaf, subleaf, regs);
-	*reg = regs[regidx];
-}
-
-#define cpuid_subleaf_reg(leaf, subleaf, regidx, reg) {		\
-	static_assert(sizeof(*(reg)) == 4);			\
-	__cpuid_read_reg(leaf, subleaf, regidx, (u32 *)(reg));	\
-}
-
-#define cpuid_leaf_reg(leaf, regidx, reg) {			\
-	static_assert(sizeof(*(reg)) == 4);			\
-	__cpuid_read_reg(leaf, 0, regidx, (u32 *)(reg));	\
-}
-
-static __always_inline bool cpuid_function_is_indexed(u32 function)
-{
-	switch (function) {
-	case 4:
-	case 7:
-	case 0xb:
-	case 0xd:
-	case 0xf:
-	case 0x10:
-	case 0x12:
-	case 0x14:
-	case 0x17:
-	case 0x18:
-	case 0x1d:
-	case 0x1e:
-	case 0x1f:
-	case 0x24:
-	case 0x8000001d:
-		return true;
-	}
-
-	return false;
-}
-
-#define for_each_possible_hypervisor_cpuid_base(function) \
-	for (function = 0x40000000; function < 0x40010000; function += 0x100)
-
-static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
-{
-	uint32_t base, eax, signature[3];
-
-	for_each_possible_hypervisor_cpuid_base(base) {
-		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);
-
-		/*
-		 * This must not compile to "call memcmp" because it's called
-		 * from PVH early boot code before instrumentation is set up
-		 * and memcmp() itself may be instrumented.
-		 */
-		if (!__builtin_memcmp(sig, signature, 12) &&
-		    (leaves == 0 || ((eax - base) >= leaves)))
-			return base;
-	}
-
-	return 0;
-}
+#include <asm/cpuid/api.h>
 
 #endif /* _ASM_X86_CPUID_H */
diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
new file mode 100644
index 000000000000..4d1da9cc8b6f
--- /dev/null
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -0,0 +1,208 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_X86_CPUID_API_H
+#define _ASM_X86_CPUID_API_H
+
+#include <linux/build_bug.h>
+#include <linux/types.h>
+
+#include <asm/cpuid/types.h>
+#include <asm/string.h>
+
+/*
+ * Raw CPUID accessors
+ */
+
+#ifdef CONFIG_X86_32
+bool have_cpuid_p(void);
+#else
+static inline bool have_cpuid_p(void)
+{
+	return true;
+}
+#endif
+static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
+				unsigned int *ecx, unsigned int *edx)
+{
+	/* ecx is often an input as well as an output. */
+	asm volatile("cpuid"
+	    : "=a" (*eax),
+	      "=b" (*ebx),
+	      "=c" (*ecx),
+	      "=d" (*edx)
+	    : "0" (*eax), "2" (*ecx)
+	    : "memory");
+}
+
+#define native_cpuid_reg(reg)					\
+static inline unsigned int native_cpuid_##reg(unsigned int op)	\
+{								\
+	unsigned int eax = op, ebx, ecx = 0, edx;		\
+								\
+	native_cpuid(&eax, &ebx, &ecx, &edx);			\
+								\
+	return reg;						\
+}
+
+/*
+ * Native CPUID functions returning a single datum.
+ */
+native_cpuid_reg(eax)
+native_cpuid_reg(ebx)
+native_cpuid_reg(ecx)
+native_cpuid_reg(edx)
+
+#ifdef CONFIG_PARAVIRT_XXL
+#include <asm/paravirt.h>
+#else
+#define __cpuid			native_cpuid
+#endif
+
+/*
+ * Generic CPUID function
+ * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
+ * resulting in stale register contents being returned.
+ */
+static inline void cpuid(unsigned int op,
+			 unsigned int *eax, unsigned int *ebx,
+			 unsigned int *ecx, unsigned int *edx)
+{
+	*eax = op;
+	*ecx = 0;
+	__cpuid(eax, ebx, ecx, edx);
+}
+
+/* Some CPUID calls want 'count' to be placed in ecx */
+static inline void cpuid_count(unsigned int op, int count,
+			       unsigned int *eax, unsigned int *ebx,
+			       unsigned int *ecx, unsigned int *edx)
+{
+	*eax = op;
+	*ecx = count;
+	__cpuid(eax, ebx, ecx, edx);
+}
+
+/*
+ * CPUID functions returning a single datum
+ */
+
+static inline unsigned int cpuid_eax(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+
+	return eax;
+}
+
+static inline unsigned int cpuid_ebx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+
+	return ebx;
+}
+
+static inline unsigned int cpuid_ecx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+
+	return ecx;
+}
+
+static inline unsigned int cpuid_edx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+
+	return edx;
+}
+
+static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32 *regs)
+{
+	regs[CPUID_EAX] = leaf;
+	regs[CPUID_ECX] = subleaf;
+	__cpuid(regs + CPUID_EAX, regs + CPUID_EBX, regs + CPUID_ECX, regs + CPUID_EDX);
+}
+
+#define cpuid_subleaf(leaf, subleaf, regs) {		\
+	static_assert(sizeof(*(regs)) == 16);		\
+	__cpuid_read(leaf, subleaf, (u32 *)(regs));	\
+}
+
+#define cpuid_leaf(leaf, regs) {			\
+	static_assert(sizeof(*(regs)) == 16);		\
+	__cpuid_read(leaf, 0, (u32 *)(regs));		\
+}
+
+static inline void __cpuid_read_reg(unsigned int leaf, unsigned int subleaf,
+				    enum cpuid_regs_idx regidx, u32 *reg)
+{
+	u32 regs[4];
+
+	__cpuid_read(leaf, subleaf, regs);
+	*reg = regs[regidx];
+}
+
+#define cpuid_subleaf_reg(leaf, subleaf, regidx, reg) {		\
+	static_assert(sizeof(*(reg)) == 4);			\
+	__cpuid_read_reg(leaf, subleaf, regidx, (u32 *)(reg));	\
+}
+
+#define cpuid_leaf_reg(leaf, regidx, reg) {			\
+	static_assert(sizeof(*(reg)) == 4);			\
+	__cpuid_read_reg(leaf, 0, regidx, (u32 *)(reg));	\
+}
+
+static __always_inline bool cpuid_function_is_indexed(u32 function)
+{
+	switch (function) {
+	case 4:
+	case 7:
+	case 0xb:
+	case 0xd:
+	case 0xf:
+	case 0x10:
+	case 0x12:
+	case 0x14:
+	case 0x17:
+	case 0x18:
+	case 0x1d:
+	case 0x1e:
+	case 0x1f:
+	case 0x24:
+	case 0x8000001d:
+		return true;
+	}
+
+	return false;
+}
+
+#define for_each_possible_hypervisor_cpuid_base(function) \
+	for (function = 0x40000000; function < 0x40010000; function += 0x100)
+
+static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
+{
+	uint32_t base, eax, signature[3];
+
+	for_each_possible_hypervisor_cpuid_base(base) {
+		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);
+
+		/*
+		 * This must not compile to "call memcmp" because it's called
+		 * from PVH early boot code before instrumentation is set up
+		 * and memcmp() itself may be instrumented.
+		 */
+		if (!__builtin_memcmp(sig, signature, 12) &&
+		    (leaves == 0 || ((eax - base) >= leaves)))
+			return base;
+	}
+
+	return 0;
+}
+
+#endif /* _ASM_X86_CPUID_API_H */
diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
new file mode 100644
index 000000000000..724002aaff4d
--- /dev/null
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CPUID_TYPES_H
+#define _ASM_X86_CPUID_TYPES_H
+
+#include <linux/types.h>
+
+/*
+ * Types for raw CPUID access
+ */
+
+struct cpuid_regs {
+	u32 eax, ebx, ecx, edx;
+};
+
+enum cpuid_regs_idx {
+	CPUID_EAX = 0,
+	CPUID_EBX,
+	CPUID_ECX,
+	CPUID_EDX,
+};
+
+#define CPUID_LEAF_MWAIT	0x5
+#define CPUID_LEAF_DCA		0x9
+#define CPUID_LEAF_XSTATE	0x0d
+#define CPUID_LEAF_TSC		0x15
+#define CPUID_LEAF_FREQ		0x16
+#define CPUID_LEAF_TILE		0x1d
+
+#endif /* _ASM_X86_CPUID_TYPES_H */
-- 
2.45.2


