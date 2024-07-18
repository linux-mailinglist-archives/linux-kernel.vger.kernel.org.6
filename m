Return-Path: <linux-kernel+bounces-256356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FA1934CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277FD1F2399A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1365313B295;
	Thu, 18 Jul 2024 12:07:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2FC12C473
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721304436; cv=none; b=AZfUyM8cGXNMh4mQ1aAtyyH81nTR2KLrqSE0IzufjyIQLPaD2TpBPpHhkIYk6p/Ci6pyjJxtCv5tqC7ZzFq3gJwTSiSj1ye7wP5trLevs0W0QXg+smMckQL6AVbjMd5mKbZvGxPBBZqGfTbf40iATTN74+TbTMsP7yEbgnpRyCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721304436; c=relaxed/simple;
	bh=DNBMocFKMlBc4naeA5BAkg+RIDCNP4lvbMF7Y2MTE/I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nUj/w6++eKdjLpU8yotpxTFSjs6xsyw5lNFxjfP4PaDFS5ADrd04JKjEcDj5q8g3zfyu08NNKSXAR7hTduCe37XlHsiYhddYvoMNlPaEsyDLsx5T96Wzmo9+jzD/UWQM7rAY16oNEMieeSKW6QDtpdmHCheHFkUS0zmj5q+GA9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D23331063;
	Thu, 18 Jul 2024 05:07:31 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C2A0D3F766;
	Thu, 18 Jul 2024 05:07:04 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: alex.coplan@arm.com,
	catalin.marinas@arm.com,
	jakub@gcc.gnu.org,
	linux-arm-kernel@lists.infradead.org,
	mark.rutland@arm.com,
	peterz@infradead.org,
	seanjc@google.com,
	szabolcs.nagy@arm.com,
	torvalds@linux-foundation.org,
	will@kernel.org
Subject: [PATCH] init/Kconfig: remove CONFIG_GCC_ASM_GOTO_OUTPUT_WORKAROUND
Date: Thu, 18 Jul 2024 13:06:47 +0100
Message-Id: <20240718120647.1115592-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several versions of GCC mis-compile asm goto with outputs. We try to
workaround this, but our workaround is demonstrably incomplete and
liable to result in subtle bugs, especially on arm64 where get_user()
has recently been moved over to using asm goto with outputs.

From discussion(s) with Linus at:

  https://lore.kernel.org/linux-arm-kernel/Zpfv2tnlQ-gOLGac@J2N7QTR9R3.cambridge.arm.com/
  https://lore.kernel.org/linux-arm-kernel/ZpfxLrJAOF2YNqCk@J2N7QTR9R3.cambridge.arm.com/

... it sounds like the best thing to do for now is to remove the workaround and
make CC_HAS_ASM_GOTO_OUTPUT depend on working compiler versions.

The issue was originally reported to GCC by Sean Christopherson:

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113921

... and Jakub Jelinek fixed this for GCC 14, with the fix backported to
13.3.0, 12.4.0, and 11.5.0.

In the kernel, we tried to workaround broken compilers in commits:

  4356e9f841f7 ("work around gcc bugs with 'asm goto' with outputs")
  68fb3ca0e408 ("update workarounds for gcc "asm goto" issue")

... but the workaround of adding an empty asm("") after the asm volatile
goto(...) demonstrably does not always avoid the problem, as can be seen
in the following test case:

| #define asm_goto_output(x...) \
|         do { asm volatile goto(x); asm (""); } while (0)
|
| #define __good_or_bad(__val, __key)                                     \
| do {                                                                    \
|         __label__ __failed;                                             \
|         unsigned long __tmp;                                            \
|         asm_goto_output(                                                \
|         "       cbnz    %[key], %l[__failed]\n"                         \
|         "       mov     %[val], #0x900d\n"                              \
|         : [val] "=r" (__tmp)                                            \
|         : [key] "r" (__key)                                             \
|         :                                                               \
|         : __failed);                                                    \
|         (__val) = __tmp;                                                \
|         break;                                                          \
| __failed:                                                               \
|         (__val) = 0xbad;                                                \
| } while (0)
|
| unsigned long get_val(unsigned long key);
| unsigned long get_val(unsigned long key)
| {
|         unsigned long val = 0xbad;
|
|         __good_or_bad(val, key);
|
|         return val;
| }

GCC 13.2.0 (at -O2) compiles this to:

| 	cbnz    x0, .Lfailed
| 	mov     x0, #0x900d
| .Lfailed:
| 	ret

GCC 14.1.0 (at -O2) compiles this to:

| 	cbnz    x0, .Lfailed
| 	mov     x0, #0x900d
| 	ret
| .Lfailed:
| 	mov     x0, #0xbad
| 	ret

Note that GCC 13.2.0 erroneously omits the assignment to 'val' in the
error path (even though this does not depend on an output of the asm
goto). GCC 14.1.0 correctly retains the assignment.

This problem can be seen within the kernel with the following test case:

| #include <linux/uaccess.h>
| #include <linux/types.h>
|
| noinline unsigned long test_unsafe_get_user(unsigned long __user *ptr);
| noinline unsigned long test_unsafe_get_user(unsigned long __user *ptr)
| {
|         unsigned long val;
|
|         unsafe_get_user(val, ptr, Efault);
|         return val;
|
| Efault:
|         val = 0x900d;
|         return val;
| }

GCC 13.2.0 (arm64 defconfig) compiles this to:

|         and     x0, x0, #0xff7fffffffffffff
|         ldtr    x0, [x0]
| .Lextable_fixup:
|         ret

GCC 13.2.0 (x86_64 defconfig + MITIGATION_RETPOLINE=n) compiles this to:

|         endbr64
|         mov    (%rdi),%rax
| .Lextable_fixup:
|         ret

... omitting the assignment to 'val' in the error path, and leaving
garbage in the result register returned by the function (which happens
to contain the faulting address in the generated code).

GCC 14.1.0 (arm64 defconfig) compiles this to:

|         and     x0, x0, #0xff7fffffffffffff
|         ldtr    x0, [x0]
|         ret
| .Lextable_fixup:
|         mov     x0, #0x900d                     // #36877
|         ret

GCC 14.1.0 (x86_64 defconfig + MITIGATION_RETPOLINE=n) compiles this to:

|         endbr64
|         mov    (%rdi),%rax
|         ret
| .Lextable_fixup:
|         mov    $0x900d,%eax
|         ret

... retaining the expected assignment to 'val' in the error path.

We don't have a complete and reasonable workaround. While placing empty
asm("") blocks after each goto label *might* be sufficient, we don't
know for certain, this is tedious and error-prone, and there doesn't
seem to be a neat way to wrap this up (which is especially painful for
cases with multiple goto labels).

Avoid this issue by disabling CONFIG_CC_HAS_ASM_GOTO_OUTPUT for
known-broken compiler versions and removing the workaround (along with
the CONFIG_GCC_ASM_GOTO_OUTPUT_WORKAROUND config option).

For the moment I've left the default implementation of asm_goto_output()
unchanged. This should now be redundant since any compiler with the fix
for the clobbering issue whould also have a fix for the (earlier)
volatile issue, but it's far less churny to leave it around, which makes
it easier to backport this patch if necessary.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alex Coplan <alex.coplan@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jakub Jelinek <jakub@gcc.gnu.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/compiler-gcc.h | 20 --------------------
 init/Kconfig                 | 14 +++++---------
 2 files changed, 5 insertions(+), 29 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index aff92b1d284fd..f805adaa316e9 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -64,26 +64,6 @@
 		__builtin_unreachable();	\
 	} while (0)
 
-/*
- * GCC 'asm goto' with outputs miscompiles certain code sequences:
- *
- *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113921
- *
- * Work around it via the same compiler barrier quirk that we used
- * to use for the old 'asm goto' workaround.
- *
- * Also, always mark such 'asm goto' statements as volatile: all
- * asm goto statements are supposed to be volatile as per the
- * documentation, but some versions of gcc didn't actually do
- * that for asms with outputs:
- *
- *    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=98619
- */
-#ifdef CONFIG_GCC_ASM_GOTO_OUTPUT_WORKAROUND
-#define asm_goto_output(x...) \
-	do { asm volatile goto(x); asm (""); } while (0)
-#endif
-
 #if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP)
 #define __HAVE_BUILTIN_BSWAP32__
 #define __HAVE_BUILTIN_BSWAP64__
diff --git a/init/Kconfig b/init/Kconfig
index febdea2afc3be..e236498911870 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -82,6 +82,11 @@ config CC_CAN_LINK_STATIC
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
 
 config CC_HAS_ASM_GOTO_OUTPUT
+	# Fixed in GCC 14, 13.3, 12.4 and 11.5
+	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113921
+	default n if CC_IS_GCC && GCC_VERSION < 110500
+	default n if CC_IS_GCC && GCC_VERSION >= 120000 && GCC_VERSION < 120400
+	default n if CC_IS_GCC && GCC_VERSION >= 130000 && GCC_VERSION < 130300
 	def_bool $(success,echo 'int foo(int x) { asm goto ("": "=r"(x) ::: bar); return x; bar: return 0; }' | $(CC) -x c - -c -o /dev/null)
 
 config CC_HAS_ASM_GOTO_TIED_OUTPUT
@@ -89,15 +94,6 @@ config CC_HAS_ASM_GOTO_TIED_OUTPUT
 	# Detect buggy gcc and clang, fixed in gcc-11 clang-14.
 	def_bool $(success,echo 'int foo(int *x) { asm goto (".long (%l[bar]) - .": "+m"(*x) ::: bar); return *x; bar: return 0; }' | $CC -x c - -c -o /dev/null)
 
-config GCC_ASM_GOTO_OUTPUT_WORKAROUND
-	bool
-	depends on CC_IS_GCC && CC_HAS_ASM_GOTO_OUTPUT
-	# Fixed in GCC 14, 13.3, 12.4 and 11.5
-	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113921
-	default y if GCC_VERSION < 110500
-	default y if GCC_VERSION >= 120000 && GCC_VERSION < 120400
-	default y if GCC_VERSION >= 130000 && GCC_VERSION < 130300
-
 config TOOLS_SUPPORT_RELR
 	def_bool $(success,env "CC=$(CC)" "LD=$(LD)" "NM=$(NM)" "OBJCOPY=$(OBJCOPY)" $(srctree)/scripts/tools-support-relr.sh)
 
-- 
2.30.2


