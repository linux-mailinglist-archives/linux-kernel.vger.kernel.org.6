Return-Path: <linux-kernel+bounces-562207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EEEA61F37
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DEE462889
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB206205AD8;
	Fri, 14 Mar 2025 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryIPU3kh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472FD1FA856
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988515; cv=none; b=KdVEsOXWcvuNRWqztx2vQlLp/q19WSwMCV3iXRUbIAjoK3UXYPCJkayfpQ1sUNmGts4kAOrPhRr+/uomzgz1JguNMxaf0hoH7M+rjgSoAjV3z+EghUifwgfw/Xm+pFrV18vSIcKyalCkkf52QBVeZyufA5ke3dXZqb4BoTvIboM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988515; c=relaxed/simple;
	bh=x+l2LdwKG2r1cBZTTsew5lGF5mDXEqksJXo/DOHT6uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyOtd0sq25RDMcbEAgwlgg9x7lulN7JC4jXPYTLBZYC43+qwA5yuHRazMcxY2kZSLbRyk9kTU4UXMqhiQuqZAc8p2WPs2IUKi4/PtpUHPR6ggLhTCbz4MOQbXIPpSTJXpYpMMJivbGbCrgKt3EFak0lWW3yYAHtIZFMchDI7yrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryIPU3kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C1FC4CEEE;
	Fri, 14 Mar 2025 21:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988514;
	bh=x+l2LdwKG2r1cBZTTsew5lGF5mDXEqksJXo/DOHT6uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ryIPU3khRA5CfmNUlsTYFAu+IUvao7zDIA8G9z7OoU4eX5XoRiBVlQMV8m6F8ZJIL
	 JeK3AwxJXyBQ8W1bK/plKY3qQr5HwNuz82O1ZhduuYKXh1iwzqko1QrK1h2ZkZkgjv
	 85wUTKnLi/w+6f02GXf/FhGwnVobOH9dJfmifXRqD9l6pkbYzdh8YC6eLI7DixRETL
	 QvLcebHLtCavc1bBQMImiv3bDLYPji+hXHHeqGnzGlNhs3pB62d9G199OxqQXY0fhO
	 cATQT3JJDOhspNxUV3/tC1+dY4yS93XdHJJYEJOwijI1ksbGbqwkdH050EPCbU7aQl
	 udwQw/DYtXaUg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 01/20] x86/cpu: Use named asm operands in prefetch[w]()
Date: Fri, 14 Mar 2025 14:41:14 -0700
Message-ID: <0e7fb0082e4d4d2b303819a2cef243a32fd86774.1741988314.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741988314.git.jpoimboe@kernel.org>
References: <cover.1741988314.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use named operands in preparation for removing the operand numbering
restrictions in alternative_input().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/processor.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 5d2f7e5aff26..2e9566134949 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -613,7 +613,7 @@ extern char			ignore_fpu_irq;
 # define BASE_PREFETCH		""
 # define ARCH_HAS_PREFETCH
 #else
-# define BASE_PREFETCH		"prefetcht0 %1"
+# define BASE_PREFETCH		"prefetcht0 %[val]"
 #endif
 
 /*
@@ -624,9 +624,9 @@ extern char			ignore_fpu_irq;
  */
 static inline void prefetch(const void *x)
 {
-	alternative_input(BASE_PREFETCH, "prefetchnta %1",
-			  X86_FEATURE_XMM,
-			  "m" (*(const char *)x));
+	alternative_input(BASE_PREFETCH,
+			  "prefetchnta %[val]", X86_FEATURE_XMM,
+			  [val] "m" (*(const char *)x));
 }
 
 /*
@@ -636,9 +636,9 @@ static inline void prefetch(const void *x)
  */
 static __always_inline void prefetchw(const void *x)
 {
-	alternative_input(BASE_PREFETCH, "prefetchw %1",
-			  X86_FEATURE_3DNOWPREFETCH,
-			  "m" (*(const char *)x));
+	alternative_input(BASE_PREFETCH,
+			  "prefetchw %[val]", X86_FEATURE_3DNOWPREFETCH,
+			  [val] "m" (*(const char *)x));
 }
 
 #define TOP_OF_INIT_STACK ((unsigned long)&init_stack + sizeof(init_stack) - \
-- 
2.48.1


