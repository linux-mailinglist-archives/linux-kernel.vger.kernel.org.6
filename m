Return-Path: <linux-kernel+bounces-192677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E33A8D208D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD462886B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B48171678;
	Tue, 28 May 2024 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ko0jqU8Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E7B1DFD1
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910642; cv=none; b=rSOhLlMeGXOdrCO9dGLpSrymCEVsV3P5lEgXQQf6jbseW0rjk1SSf2nAYk6TtpHLy51ccHN99M1piVaN/K0Aq1gbqiL41lUVvTXizKBys9MzI7V3/Jzf/nyU72mWhYj85lFukUt5C1yWH46FqByefkALP9llIMWSca+FTvVAenw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910642; c=relaxed/simple;
	bh=7zmzoPvXFhVUfVCN9/UlOHGCv01xisUHkwCvRfpy594=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cGXiHYXmNPhLaVXQqH5qvO654Aq9os3OeugN2kMaZ+8wF7kxJIRv9Y8lKQ/B56MAU90UmYW1XNGpO/IEx5mwO6INBWO+bkLFDBoDlH2suRb194sBj7cDbPoZcHf9SJI9Bcecz2/tf4g/3SdKs11DzdRER8zZYo5UfwIyK/acGX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ko0jqU8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAABC3277B;
	Tue, 28 May 2024 15:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716910642;
	bh=7zmzoPvXFhVUfVCN9/UlOHGCv01xisUHkwCvRfpy594=;
	h=From:To:Cc:Subject:Date:From;
	b=ko0jqU8QTZDtHSsT6QIpoHm1NNFx8uIxbu8d2Mik/wtpsGNfimV12494zWAPuruCp
	 olbSVSNWvhjdZLVXeZT+PHWFIbUkxsqVdnJU9dGzc6iFimTsBH7g05qpBBOisX6Sgo
	 SBzi0nhuZjNbjXEUBnVZvzzkoZtEbNNFMm9VrVblpoKMR/BAEVEIjCtBhPI2PKi88j
	 niNjMY1uzbUc3QP+VGbPTadqOfT8KMiGn4+xdYZ3GRt4/iDtnpEg2ImkoyDlJpLXzI
	 yan0DL+KBgMqv33cpptYPrnU+cY44u0mMjlN/LPmkkacv4+dMDvgV/K5n9rZ4qErgd
	 7PIlg4QJhSaAQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Baoquan He <bhe@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] arm64/io: add constant-argument check
Date: Tue, 28 May 2024 17:37:11 +0200
Message-Id: <20240528153717.2439910-1-arnd@kernel.org>
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
it is still constant if the compiler decides against inlining it.

Fixes: ead79118dae6 ("arm64/io: Provide a WC friendly __iowriteXX_copy()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
 - fix both 32-bit and 64-bit copies
 - remove now-redundant macros
---
 arch/arm64/include/asm/io.h | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 4ff0ae3f6d66..902026f81b97 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -196,21 +196,18 @@ static inline void __const_memcpy_toio_aligned32(volatile u32 __iomem *to,
 
 void __iowrite32_copy_full(void __iomem *to, const void *from, size_t count);
 
-static inline void __const_iowrite32_copy(void __iomem *to, const void *from,
-					  size_t count)
+static inline void __iowrite32_copy(void __iomem *to, const void *from,
+				    size_t count)
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
-
-#define __iowrite32_copy(to, from, count)                  \
-	(__builtin_constant_p(count) ?                     \
-		 __const_iowrite32_copy(to, from, count) : \
-		 __iowrite32_copy_full(to, from, count))
+#define __iowrite32_copy(to, from, count) __iowrite32_copy(to, from, count)
 
 static inline void __const_memcpy_toio_aligned64(volatile u64 __iomem *to,
 						 const u64 *from, size_t count)
@@ -255,21 +252,18 @@ static inline void __const_memcpy_toio_aligned64(volatile u64 __iomem *to,
 
 void __iowrite64_copy_full(void __iomem *to, const void *from, size_t count);
 
-static inline void __const_iowrite64_copy(void __iomem *to, const void *from,
+static inline void __iowrite64_copy(void __iomem *to, const void *from,
 					  size_t count)
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


