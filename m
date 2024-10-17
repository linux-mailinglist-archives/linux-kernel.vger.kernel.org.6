Return-Path: <linux-kernel+bounces-370650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 530DB9A301C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16861F224B0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A2A1D6DA3;
	Thu, 17 Oct 2024 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKQDXOec"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C61F1D2F73
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202128; cv=none; b=uEMWWD0RE5ur0S0GWETS8gSGLbKXO0Fdw4FizVMxPsjRlMOdeORncGJ69puBQNx5ckzj0oUK4j7bZ9Qs+tYBNXW14Il5THgZqOMawCgfaZtPpAEuxrVenG7Pqz3xb+js3R8qEmMF1Ps03jEyIhBPQxewa6/OCNilhDdj1VCJXQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202128; c=relaxed/simple;
	bh=NSb0CuZFRxLsMtRmJayyQ03cyCTlxrCnGaQiC+w0oD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u12uiKUjvJWrPLEKbsP4ric0Lb6elADmG1IcbfiqKETlFJLEV/oAt5hB9VnJJZ5q1scYizRRPOpaVVnaX7efHfiXPftuoVNAdwgJnP+MNedYN+6KMoL37M3ZeVuXw8cwexM2VdsYZtkvERwcI4w59jZ2NMG71h2w551Kvucr8aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKQDXOec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC073C4CED0;
	Thu, 17 Oct 2024 21:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729202128;
	bh=NSb0CuZFRxLsMtRmJayyQ03cyCTlxrCnGaQiC+w0oD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uKQDXOecdhFeWVcjmHYzxDjck9if1H7eA1+6f7NoHaSKzm99ot5/BncF/3PLUnbAh
	 RsJ7nB42/0UWG4+wIvyIna1c/vVySuR/JHzeYr/MJO63eiW2SKqcm4YmcZILD0EMv4
	 YHTgd4DfquTsJNoGTCEUdsUNZ9188sXWqzp2a6fQoIM72e1F929co1n+Mw9ljovj0q
	 wDdpYy1Vg6vEUx1jqAnmhgtzpw6DlmcpWR6hwWzIPCvf3bRNulPzegEizm04h1/bF+
	 cIsU8uiR2lVTLesSQzVBqpt6zepx/S73bzxCEFmtSxfFgGIy3L8IZsoalquT9dLCyn
	 gzwgKm5qNOFFg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Waiman Long <longman@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2 1/6] x86/uaccess: Avoid barrier_nospec() in copy_from_user()
Date: Thu, 17 Oct 2024 14:55:20 -0700
Message-ID: <e3e3698c7b891811bb1133cc7fde9a30c8b0e00a.1729201904.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729201904.git.jpoimboe@kernel.org>
References: <cover.1729201904.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For x86-64, the barrier_nospec() in copy_from_user() is overkill and
painfully slow.  Instead, use pointer masking to force the user pointer
to a non-kernel value in speculative paths.

To avoid regressing powerpc, move the barrier_nospec() to the powerpc
raw_copy_from_user() implementation so there's no functional change.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/powerpc/include/asm/uaccess.h | 2 ++
 arch/x86/include/asm/uaccess_64.h  | 7 ++++---
 arch/x86/lib/getuser.S             | 2 +-
 arch/x86/lib/putuser.S             | 2 +-
 include/linux/uaccess.h            | 6 ------
 5 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 4f5a46a77fa2..12abb8bf5eda 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -7,6 +7,7 @@
 #include <asm/extable.h>
 #include <asm/kup.h>
 #include <asm/asm-compat.h>
+#include <asm/barrier.h>
 
 #ifdef __powerpc64__
 /* We use TASK_SIZE_USER64 as TASK_SIZE is not constant */
@@ -341,6 +342,7 @@ static inline unsigned long raw_copy_from_user(void *to,
 {
 	unsigned long ret;
 
+	barrier_nospec();
 	allow_read_from_user(from, n);
 	ret = __copy_tofrom_user((__force void __user *)to, from, n);
 	prevent_read_from_user(from, n);
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index afce8ee5d7b7..61693028ea2b 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -54,11 +54,11 @@ static inline unsigned long __untagged_addr_remote(struct mm_struct *mm,
 #define valid_user_address(x) ((__force long)(x) >= 0)
 
 /*
- * Masking the user address is an alternative to a conditional
- * user_access_begin that can avoid the fencing. This only works
- * for dense accesses starting at the address.
+ * If it's a kernel address, force it to all 1's.  This prevents a mispredicted
+ * access_ok() from speculatively accessing kernel space.
  */
 #define mask_user_address(x) ((typeof(x))((long)(x)|((long)(x)>>63)))
+
 #define masked_user_access_begin(x) ({				\
 	__auto_type __masked_ptr = (x);				\
 	__masked_ptr = mask_user_address(__masked_ptr);		\
@@ -133,6 +133,7 @@ copy_user_generic(void *to, const void *from, unsigned long len)
 static __always_inline __must_check unsigned long
 raw_copy_from_user(void *dst, const void __user *src, unsigned long size)
 {
+	src = mask_user_address(src);
 	return copy_user_generic(dst, (__force void *)src, size);
 }
 
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index d066aecf8aeb..094224ec9dca 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -39,7 +39,7 @@
 
 .macro check_range size:req
 .if IS_ENABLED(CONFIG_X86_64)
-	mov %rax, %rdx
+	mov %rax, %rdx		/* mask_user_address() */
 	sar $63, %rdx
 	or %rdx, %rax
 .else
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 975c9c18263d..09b7e37934ab 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -34,7 +34,7 @@
 
 .macro check_range size:req
 .if IS_ENABLED(CONFIG_X86_64)
-	mov %rcx, %rbx
+	mov %rcx, %rbx		/* mask_user_address() */
 	sar $63, %rbx
 	or %rbx, %rcx
 .else
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 39c7cf82b0c2..dda9725a9559 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -160,12 +160,6 @@ _inline_copy_from_user(void *to, const void __user *from, unsigned long n)
 	unsigned long res = n;
 	might_fault();
 	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
-		/*
-		 * Ensure that bad access_ok() speculation will not
-		 * lead to nasty side effects *after* the copy is
-		 * finished:
-		 */
-		barrier_nospec();
 		instrument_copy_from_user_before(to, from, n);
 		res = raw_copy_from_user(to, from, n);
 		instrument_copy_from_user_after(to, from, n, res);
-- 
2.47.0


