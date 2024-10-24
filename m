Return-Path: <linux-kernel+bounces-379073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8979AD951
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6414283A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D036446A1;
	Thu, 24 Oct 2024 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yF2aXA17"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1F136A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729733541; cv=none; b=CZvLM6+BGJ2rUSp/UmNl5krd/ae/1sTwphg12n8mX/o9Zfftdyx8r6jIWhbBqGlSegZxdCOYbyPT8nLeR9imHKJ8m7o6bgN0U5ztJnvdsrCQ6kyliW9ELczUHnt+zqhxrxgKivX4eiJGladERGtcX0cldxWJZQudUY5T+PrG7Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729733541; c=relaxed/simple;
	bh=anAMNayDW2dpd0fEkaNGI8dtKLw4drQ+y5NAra95Q6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tg4MwLaGJnVY/q/2cwABicuvo85+YoUdGGsWGDvEAk1ake0Cy9sKAvim6YQbaEOtm0o498/5bO5r/Shy3I5mhlHA5ZfCR12YNmmtb4YSjg7zY8lh+ig6EomqeNtopLqabwJpy5RtY8VyZrCjTKmA/hpwYx0a2eVZJ8wC26RcUCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yF2aXA17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405F5C4CEC6;
	Thu, 24 Oct 2024 01:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729733541;
	bh=anAMNayDW2dpd0fEkaNGI8dtKLw4drQ+y5NAra95Q6w=;
	h=From:To:Cc:Subject:Date:From;
	b=yF2aXA17RcqwcSS3LTJs5rCLJNrVhjTZo3QKD9hwnKZTWjG6RkhdotwApoqE+zVK6
	 SdrBDtS1mL/xvB6pPWZhZPhVcjefZelnwy0GVadiyHTPQ69zr456au7qWIelq+fMwt
	 dl/3WFIKm2EgjTrOLNJrWJ2JDj0YGW5/apvPA7xQ=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH] x86: fix user address masking non-canonical speculation issue
Date: Wed, 23 Oct 2024 18:31:59 -0700
Message-ID: <20241024013214.129639-1-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.46.1.608.gc56f2c11c8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It turns out that AMD has a "Meltdown Lite(tm)" issue with non-canonical
accesses in kernel space.  And so using just the high bit to decide
whether an access is in user space or kernel space ends up with the good
old "leak speculative data" if you have the right gadget using the
result:

  CVE-2020-12965 “Transient Execution of Non-Canonical Accesses“

Now, the kernel surrounds the access with a STAC/CLAC pair, and those
instructions end up serializing execution on older Zen architectures,
which closes the speculation window.

But that was true only up until Zen 5, which renames the AC bit [1].
That improves performance of STAC/CLAC a lot, but also means that the
speculation window is now open.

Note that this affects not just the new address masking, but also the
regular valid_user_address() check used by access_ok(), and the asm
version of the sign bit check in the get_user() helpers.

It does not affect put_user() or clear_user() variants, since there's no
speculative result to be used in a gadget for those operations.

Reported-by: Andrew Cooper <andrew.cooper3@citrix.com>
Link: https://lore.kernel.org/all/80d94591-1297-4afb-b510-c665efd37f10@citrix.com/
Link: https://lore.kernel.org/all/20241023094448.GAZxjFkEOOF_DM83TQ@fat_crate.local/ [1]
Link: https://www.amd.com/en/resources/product-security/bulletin/amd-sb-1010.html
Link: https://arxiv.org/pdf/2108.10771
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Fixes: 2865baf54077 ("x86: support user address masking instead of non-speculative conditional")
Fixes: 6014bc27561f ("x86-64: make access_ok() independent of LAM")
Fixes: b19b74bc99b1 ("x86/mm: Rework address range check in get_user() and put_user()")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/include/asm/uaccess_64.h | 25 ++++++++++++++++++-------
 arch/x86/kernel/cpu/common.c      | 10 ++++++++++
 arch/x86/kernel/vmlinux.lds.S     |  1 +
 arch/x86/lib/getuser.S            |  9 +++++++--
 4 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index afce8ee5d7b7..c03d49c4fe54 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -12,6 +12,13 @@
 #include <asm/cpufeatures.h>
 #include <asm/page.h>
 #include <asm/percpu.h>
+#include <asm/runtime-const.h>
+
+/*
+ * Virtual variable: there's no actual backing store for this,
+ * it can purely be used as 'runtime_const_ptr(USER_PTR_MAX)'
+ */
+extern unsigned long USER_PTR_MAX;
 
 #ifdef CONFIG_ADDRESS_MASKING
 /*
@@ -46,19 +53,23 @@ static inline unsigned long __untagged_addr_remote(struct mm_struct *mm,
 
 #endif
 
-/*
- * The virtual address space space is logically divided into a kernel
- * half and a user half.  When cast to a signed type, user pointers
- * are positive and kernel pointers are negative.
- */
-#define valid_user_address(x) ((__force long)(x) >= 0)
+#define valid_user_address(x) \
+	((__force unsigned long)(x) < runtime_const_ptr(USER_PTR_MAX))
 
 /*
  * Masking the user address is an alternative to a conditional
  * user_access_begin that can avoid the fencing. This only works
  * for dense accesses starting at the address.
  */
-#define mask_user_address(x) ((typeof(x))((long)(x)|((long)(x)>>63)))
+static inline void __user *mask_user_address(const void __user *ptr)
+{
+	void __user *ret;
+	asm("cmp %1,%0; sbb %0,%0; or %1,%0"
+		:"=r" (ret)
+		:"r" (ptr),
+		 "0" (runtime_const_ptr(USER_PTR_MAX)));
+	return ret;
+}
 #define masked_user_access_begin(x) ({				\
 	__auto_type __masked_ptr = (x);				\
 	__masked_ptr = mask_user_address(__masked_ptr);		\
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f1040cb64841..d671f78f658e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -69,6 +69,7 @@
 #include <asm/sev.h>
 #include <asm/tdx.h>
 #include <asm/posted_intr.h>
+#include <asm/runtime-const.h>
 
 #include "cpu.h"
 
@@ -2389,6 +2390,15 @@ void __init arch_cpu_finalize_init(void)
 	alternative_instructions();
 
 	if (IS_ENABLED(CONFIG_X86_64)) {
+		unsigned long USER_PTR_MAX = TASK_SIZE_MAX;
+
+		/*
+		 * Enable this when LAM is gated on LASS support
+		if (cpu_feature_enabled(X86_FEATURE_LAM))
+			USER_PTR_MAX = (1ul << 63) - PAGE_SIZE;
+		 */
+		runtime_const_init(ptr, USER_PTR_MAX);
+
 		/*
 		 * Make sure the first 2MB area is not mapped by huge pages
 		 * There are typically fixed size MTRRs in there and overlapping
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 6726be89b7a6..b8c5741d2fb4 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -358,6 +358,7 @@ SECTIONS
 #endif
 
 	RUNTIME_CONST_VARIABLES
+	RUNTIME_CONST(ptr, USER_PTR_MAX)
 
 	. = ALIGN(PAGE_SIZE);
 
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index d066aecf8aeb..4357ec2a0bfc 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -39,8 +39,13 @@
 
 .macro check_range size:req
 .if IS_ENABLED(CONFIG_X86_64)
-	mov %rax, %rdx
-	sar $63, %rdx
+	movq $0x0123456789abcdef,%rdx
+  1:
+  .pushsection runtime_ptr_USER_PTR_MAX,"a"
+	.long 1b - 8 - .
+  .popsection
+	cmp %rax, %rdx
+	sbb %rdx, %rdx
 	or %rdx, %rax
 .else
 	cmp $TASK_SIZE_MAX-\size+1, %eax
-- 
2.46.1.608.gc56f2c11c8


