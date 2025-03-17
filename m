Return-Path: <linux-kernel+bounces-565139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D454AA661AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3DF43B76B7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41830204F6A;
	Mon, 17 Mar 2025 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvfvvnHf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91303204C39
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250657; cv=none; b=TFGMRw40cflIrrT2rtQNETk+V/q7JsMI9GwDEOyPOGLbxpKkVFDldQHxMOxKXcO2tQdLZKGyuZ5UrqccWGqJRhe7DjokawNal3KGZxd4dRCk648v7x9W9WWrMPx47Gu0yWfnxwzZ2mAsbSCb4DU+KYc40cnOmjUZtiHJv5pyLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250657; c=relaxed/simple;
	bh=OPIWwrqa3Yqq6CoPPNn6d5qUoYzQ3042gpCOIQHRUMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSx7KcxRvDuJ9VCOb61OCYTsji/mlIaSgnUwqfuiIZ4MLzdb4o+7rxqoqYxccoimge4yRa3Sa3P6+o7gFWDwVOj6MCRPD+yV9JiPsO7SDs2NOOznDYM6XAvkfSh8cOB3k4FM4ij80JH73HIGvNDOyw0gPo7AT2AjB7rKCAVC8WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvfvvnHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CAEC4CEEF;
	Mon, 17 Mar 2025 22:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742250657;
	bh=OPIWwrqa3Yqq6CoPPNn6d5qUoYzQ3042gpCOIQHRUMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZvfvvnHfbTQ8TTqUJIFUo4w16o4i5TtWOaktIi274OOi2P7974zYIutGUMrJhqIyT
	 diLBdsluBgbwiWN8oLkvo3wSklMCjfRskJVWD0/uMN7WIRGi91OsskUizcU0p/QkFU
	 wxlf5AaTebkGkq82l5AIuOjnLaf5nhd841sND1tKC3S0qk3/r4nQyOhOFRErv15RyL
	 SPqELSlqWsAKFisxSurV69IrH4fXACP9B+8JHBgvns07HKsLAlDKKpuP7y44gvuQvA
	 I/wRlk79QJ8v9rVkHO0b9uJV10/Ez6VbRnp7ytpjJ9ErJhfSB9HEyYgNNPORySKzgW
	 ruNvQGbaHwUpg==
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
Subject: [PATCH 3/5] x86/cpuid: Clean up <asm/cpuid/api.h>
Date: Mon, 17 Mar 2025 23:30:37 +0100
Message-ID: <20250317223039.3741082-4-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250317223039.3741082-1-mingo@kernel.org>
References: <20250317223039.3741082-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ingo Molnar <mingo@kernel.org>

 - Include <asm/cpuid/types.h> first, as is customary. This also has
   the side effect of build-testing the header dependency assumptions
   in the types header.

 - No newline necessary after the SPDX line

 - Newline necessary after inline function definitions

 - Rename native_cpuid_reg() to NATIVE_CPUID_REG(): it's a CPP macro,
   whose name we capitalize in such cases.

 - Prettify the CONFIG_PARAVIRT_XXL inclusion block a bit

 - Standardize register references in comments to EAX/EBX/ECX/etc.,
   from the hodgepodge of references.

 - s/cpus/CPUs because why add noise to common acronyms?

 - Use u32 instead of uint32_t in hypervisor_cpuid_base(). Yes, I realize
   uint32_t is used in Xen code, but this is a core x86 architecture header
   and we should standardize on the type that is being used overwhelmingly
   in x86 architecture code. The two types are the same so there should be
   no build warnings.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ahmed S. Darwish <darwi@linutronix.de>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250317164745.4754-3-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid/api.h | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index 4d1da9cc8b6f..f26926ba5289 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -1,16 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
 #ifndef _ASM_X86_CPUID_API_H
 #define _ASM_X86_CPUID_API_H
 
+#include <asm/cpuid/types.h>
+
 #include <linux/build_bug.h>
 #include <linux/types.h>
 
-#include <asm/cpuid/types.h>
 #include <asm/string.h>
 
 /*
- * Raw CPUID accessors
+ * Raw CPUID accessors:
  */
 
 #ifdef CONFIG_X86_32
@@ -21,6 +21,7 @@ static inline bool have_cpuid_p(void)
 	return true;
 }
 #endif
+
 static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
 				unsigned int *ecx, unsigned int *edx)
 {
@@ -34,7 +35,7 @@ static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
 	    : "memory");
 }
 
-#define native_cpuid_reg(reg)					\
+#define NATIVE_CPUID_REG(reg)					\
 static inline unsigned int native_cpuid_##reg(unsigned int op)	\
 {								\
 	unsigned int eax = op, ebx, ecx = 0, edx;		\
@@ -45,22 +46,23 @@ static inline unsigned int native_cpuid_##reg(unsigned int op)	\
 }
 
 /*
- * Native CPUID functions returning a single datum.
+ * Native CPUID functions returning a single datum:
  */
-native_cpuid_reg(eax)
-native_cpuid_reg(ebx)
-native_cpuid_reg(ecx)
-native_cpuid_reg(edx)
+NATIVE_CPUID_REG(eax)
+NATIVE_CPUID_REG(ebx)
+NATIVE_CPUID_REG(ecx)
+NATIVE_CPUID_REG(edx)
 
 #ifdef CONFIG_PARAVIRT_XXL
-#include <asm/paravirt.h>
+# include <asm/paravirt.h>
 #else
-#define __cpuid			native_cpuid
+# define __cpuid native_cpuid
 #endif
 
 /*
  * Generic CPUID function
- * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
+ *
+ * Clear ECX since some CPUs (Cyrix MII) do not set or clear ECX
  * resulting in stale register contents being returned.
  */
 static inline void cpuid(unsigned int op,
@@ -72,7 +74,7 @@ static inline void cpuid(unsigned int op,
 	__cpuid(eax, ebx, ecx, edx);
 }
 
-/* Some CPUID calls want 'count' to be placed in ecx */
+/* Some CPUID calls want 'count' to be placed in ECX */
 static inline void cpuid_count(unsigned int op, int count,
 			       unsigned int *eax, unsigned int *ebx,
 			       unsigned int *ecx, unsigned int *edx)
@@ -83,7 +85,7 @@ static inline void cpuid_count(unsigned int op, int count,
 }
 
 /*
- * CPUID functions returning a single datum
+ * CPUID functions returning a single datum:
  */
 
 static inline unsigned int cpuid_eax(unsigned int op)
-- 
2.45.2


