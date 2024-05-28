Return-Path: <linux-kernel+bounces-192254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84348D1AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9771F23E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F3B16D325;
	Tue, 28 May 2024 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7qh64kG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1E7161321
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898139; cv=none; b=tljomjEEpmw1YYIXBGMT4TswkecrzRUPOQM1sRyXc/dMaY4dwzgEpFVvz/ExCZYsb2j5nIWBggyw9lLmIJ7oKDuXfHAXjcmDjYM0KbA+5getupnms8cmVnskpYhSxYPNEtimmnHIVhztsn17JPyH4tMHamX4hyWt97MmiIlD+u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898139; c=relaxed/simple;
	bh=w6udFbCiRu8HpcofWpGaBLqg07cyLn7e+XFXRMvBuRg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GSdEuvNyGlwgUbNzITAk1izbmtYWy1DYvmsRCmJEIAjQU7RjrnZGmVSX3/P9At0ipr+Yf3OJfV7x10yUQmxyOXclYTyWXQX2ROnsFYL5SI8nTfvQWwmSorgDgUzY1d2mTvmgn3ACQP0iNsjf9hpUbNP6cBSzUJuZu2I5bmoWVNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7qh64kG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D338BC3277B;
	Tue, 28 May 2024 12:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716898139;
	bh=w6udFbCiRu8HpcofWpGaBLqg07cyLn7e+XFXRMvBuRg=;
	h=From:To:Cc:Subject:Date:From;
	b=l7qh64kGo19wQmwy4mvyYsNucOOD2AdVlNj5Zx8SNaH6r+YPNDmtHhGiy9ujL7f60
	 LFNY72jG1FwLRJNoCPlY7pegh26Xzt5fyc4dWzGZE5QXXZ/jXsAtppnCRP2owMbe+1
	 5vrFWk5sFX57q++nxRYbjsHfBlzglwBJQgNilJpM2V04q4rBKqqINjZis2Edn24kLX
	 AVtsq1edSttUuphVxbO0EfUGgqc26HsvKtBHkJuxutqU2H0D5+Huj+chLfGghQ9kyY
	 PE+x2XXgk8yFvwx/t47QZKDdn4gLwXzxhBlkU4JhqMHApjG79dPrRUHMBrr8RV60ex
	 S3hyq660tEwpA==
From: Arnd Bergmann <arnd@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Baoquan He <bhe@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/io: add constant-argument check
Date: Tue, 28 May 2024 14:08:38 +0200
Message-Id: <20240528120844.3523915-1-arnd@kernel.org>
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

Add a check to ensure that the argument is in fact a constant before
calling into __const_memcpy_toio_aligned32().

Fixes: ead79118dae6 ("arm64/io: Provide a WC friendly __iowriteXX_copy()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/io.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 4ff0ae3f6d66..44913f227060 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -199,7 +199,8 @@ void __iowrite32_copy_full(void __iomem *to, const void *from, size_t count);
 static inline void __const_iowrite32_copy(void __iomem *to, const void *from,
 					  size_t count)
 {
-	if (count == 8 || count == 4 || count == 2 || count == 1) {
+	if (__builtin_constant_p(count) &&
+	    (count == 8 || count == 4 || count == 2 || count == 1)) {
 		__const_memcpy_toio_aligned32(to, from, count);
 		dgh();
 	} else {
-- 
2.39.2


