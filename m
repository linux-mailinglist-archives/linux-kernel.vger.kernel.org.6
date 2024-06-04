Return-Path: <linux-kernel+bounces-201373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C318FBDA9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851E72827FA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E320D14D280;
	Tue,  4 Jun 2024 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZUoecq5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C14214C5A4;
	Tue,  4 Jun 2024 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534813; cv=none; b=FGOBrSAmD+AovojPOyhHCwQY5vIMDICSckJSwdnOCuTzBaiewEpvVlz9PJZyoCz1XE0cXRdxPZHCsyGpiFinDV0smzF9gtikHxY1RoJ8QuavBbQErp0+ThL4hHSGs4QP95Mt7l7SHUY7WxP3CcrmpFv85ceTwaSuBtIXIEu+TFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534813; c=relaxed/simple;
	bh=y52S5zxbaNTrVsYNz4/Zpv7hHHKljA7FdC9ZJu7Vx30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IDF/Bwp8EGNnQyvigwz3KsdrJGsJCzmjE4OzzDn7kK8TtMFYCRgqcpXgodyr6oNglszvF5Jw4kYs3W+2N1eHjR6PoDJTzWvsw693NBghzu/Xkr6FetD4RTjdytz0oagSq5VbCGB69pcDxj6wbVYBnbycHuwzPZN8x/ku371aGS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZUoecq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA68C4AF09;
	Tue,  4 Jun 2024 21:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717534812;
	bh=y52S5zxbaNTrVsYNz4/Zpv7hHHKljA7FdC9ZJu7Vx30=;
	h=From:To:Cc:Subject:Date:From;
	b=KZUoecq5aI430xa+CHC/bW84mQfUoktWIDmalft8Y7CZBnqzMGvi5Z9K6xCw7xYWE
	 /LT9jUMOnns5TMkiMoGnaVvd7MRVn8g7aBEyFP78lYZmsnOSfOFLnc6/Rn1q5cbNM0
	 YdlYYox+iHCo1baIxGYa83wv9wDVhobB8cUmBpjAyIyQKB3rUlQRbvN2Aa4V6hunZo
	 kWTkyy75BVEf//pkTwMJ/wRG7TvrvnCSxMuPiHaad+vZQCtH8UtK6HhM1oSZs0ZjXS
	 zY1HuhofyLhx7b2wdZ3YnJfGgi1OLpNbeixjvlyPXExBW4qIdtSZUSpPenpRWdDBM9
	 yZ7/BPy1CKybg==
From: Arnd Bergmann <arnd@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] [v3] arm64/io: add constant-argument check
Date: Tue,  4 Jun 2024 22:59:57 +0200
Message-Id: <20240604210006.668912-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

In some configurations __const_iowrite32_copy() does not get inlined
and gcc runs into the BUILD_BUG():

In file included from <command-line>:
In function '__const_memcpy_toio_aligned32',
    inlined from '__const_iowrite32_copy' at arch/arm64/include/asm/io.h:203:3,
    inlined from '__const_iowrite32_copy' at arch/arm64/include/asm/io.h:199:20:
include/linux/compiler_types.h:487:45: error: call to '__compiletime_assert_538' declared with attribute error: BUILD_BUG failed
  487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
include/linux/compiler_types.h:468:25: note: in definition of macro '__compiletime_assert'
  468 |                         prefix ## suffix();                             \
      |                         ^~~~~~
include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
  487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
      |                     ^~~~~~~~~~~~~~~~
arch/arm64/include/asm/io.h:193:17: note: in expansion of macro 'BUILD_BUG'
  193 |                 BUILD_BUG();
      |                 ^~~~~~~~~

Move the check for constant arguments into the inline function to ensure
it is still constant if the compiler decides against inlining it, and
mark them as __always_inline to override the logic that sometimes leads
to the compiler not producing the simplified output.

Note that either the __always_inline annotation or the check for a
constant value are sufficient here, but combining the two looks cleaner
as it also avoids the macro. With clang-8 and older, the macro was still
needed, but all versions of gcc and clang can reliably perform constant
folding here.

Fixes: ead79118dae6 ("arm64/io: Provide a WC friendly __iowriteXX_copy()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3:
 - also mark functions as __always_inline
v2:
 - fix both 32-bit and 64-bit copies
 - remove now-redundant macros
---
 arch/arm64/include/asm/io.h | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 4ff0ae3f6d66..bc239371323a 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -153,8 +153,9 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
  * emit the large TLP from the CPU.
  */
 
-static inline void __const_memcpy_toio_aligned32(volatile u32 __iomem *to,
-						 const u32 *from, size_t count)
+static __always_inline void
+__const_memcpy_toio_aligned32(volatile u32 __iomem *to, const u32 *from,
+			      size_t count)
 {
 	switch (count) {
 	case 8:
@@ -196,24 +197,22 @@ static inline void __const_memcpy_toio_aligned32(volatile u32 __iomem *to,
 
 void __iowrite32_copy_full(void __iomem *to, const void *from, size_t count);
 
-static inline void __const_iowrite32_copy(void __iomem *to, const void *from,
-					  size_t count)
+static __always_inline void
+__iowrite32_copy(void __iomem *to, const void *from, size_t count)
 {
-	if (count == 8 || count == 4 || count == 2 || count == 1) {
+	if (__builtin_constant_p(count) &&
+	    (count == 8 || count == 4 || count == 2 || count == 1)) {
 		__const_memcpy_toio_aligned32(to, from, count);
 		dgh();
 	} else {
 		__iowrite32_copy_full(to, from, count);
 	}
 }
+#define __iowrite32_copy(to, from, count) __iowrite32_copy(to, from, count)
 
-#define __iowrite32_copy(to, from, count)                  \
-	(__builtin_constant_p(count) ?                     \
-		 __const_iowrite32_copy(to, from, count) : \
-		 __iowrite32_copy_full(to, from, count))
-
-static inline void __const_memcpy_toio_aligned64(volatile u64 __iomem *to,
-						 const u64 *from, size_t count)
+static __always_inline void
+__const_memcpy_toio_aligned64(volatile u64 __iomem *to, const u64 *from,
+			      size_t count)
 {
 	switch (count) {
 	case 8:
@@ -255,21 +254,18 @@ static inline void __const_memcpy_toio_aligned64(volatile u64 __iomem *to,
 
 void __iowrite64_copy_full(void __iomem *to, const void *from, size_t count);
 
-static inline void __const_iowrite64_copy(void __iomem *to, const void *from,
-					  size_t count)
+static __always_inline void
+__iowrite64_copy(void __iomem *to, const void *from, size_t count)
 {
-	if (count == 8 || count == 4 || count == 2 || count == 1) {
+	if (__builtin_constant_p(count) &&
+	    (count == 8 || count == 4 || count == 2 || count == 1)) {
 		__const_memcpy_toio_aligned64(to, from, count);
 		dgh();
 	} else {
 		__iowrite64_copy_full(to, from, count);
 	}
 }
-
-#define __iowrite64_copy(to, from, count)                  \
-	(__builtin_constant_p(count) ?                     \
-		 __const_iowrite64_copy(to, from, count) : \
-		 __iowrite64_copy_full(to, from, count))
+#define __iowrite64_copy(to, from, count) __iowrite64_copy(to, from, count)
 
 /*
  * I/O memory mapping functions.
-- 
2.39.2


